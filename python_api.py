from fastapi import FastAPI, UploadFile, File
import numpy as np
import cv2
import io
from PIL import Image, UnidentifiedImageError
from fastapi.responses import JSONResponse
import base64
import torch
from u_net import model


    
# load Unet
model_weights = "./model_weights/weights.pth"
model.load_state_dict(torch.load(model_weights, map_location=torch.device('cuda'), weights_only=True))
model.eval()

app = FastAPI()

def preprocess_image(image_file):
    """Resize image and convert to tensor"""
    image = Image.open(image_file).convert("RGB")
    image = image.resize((512, 512))
    image = np.array(image) / 255.0  # Normalization
    image = torch.tensor(image, dtype=torch.float32).permute(2, 0, 1).unsqueeze(0)  # (H, W, C) → (1, C, H, W)
    return image

def postprocess_mask(mask):
    """Convert model output mask to binary image (PIL format)"""
    mask = mask.squeeze().detach().cpu().numpy()  # Convert tensor to NumPy
    mask = (mask > 0.5).astype(np.uint8) * 255  # Binarization (0 or 255)
    return mask  # Return NumPy array (not PIL Image)

def plot_together(img, seg):
    """Overlay mask on image"""
    if isinstance(img, Image.Image):
        img = np.array(img)  # Convert PIL to NumPy
    if isinstance(seg, Image.Image):
        seg = np.array(seg)  # Convert PIL to NumPy
    
    # Ensure seg is grayscale
    if len(seg.shape) == 3 and seg.shape[-1] == 3:
        seg = cv2.cvtColor(seg, cv2.COLOR_RGB2GRAY)

    # Convert mask to red channel
    color_mask = np.zeros_like(img)
    color_mask[:, :, 0] = seg  # Assign to red channel

    # Overlay image and mask
    alpha = 0.5
    overlay_mask = cv2.addWeighted(img, 1 - alpha, color_mask, alpha, 0)
    return overlay_mask

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        """Get uploaded image"""
        image_bytes = await file.read()

        if not image_bytes:
            return {"error": "Can't get image"}

        """Preprocessing: convert image to tensor"""
        try:
            image_stream = io.BytesIO(image_bytes)
            input_tensor = preprocess_image(image_stream)
        except UnidentifiedImageError:
            return {"error": "Can't recognize image"}

        print(f"OK, type: {input_tensor.shape}")

        """Pass image through UNet model"""
        with torch.no_grad():
            output = model(input_tensor)
            mask_array = postprocess_mask(output)  # NumPy array

            # Convert image_bytes to PIL image
            image_pil = Image.open(io.BytesIO(image_bytes)).convert("RGB").resize((512, 512))
            seg_mask = plot_together(image_pil, mask_array)  # Overlay image

        # Convert NumPy mask to PIL image
        mask_pil = Image.fromarray(seg_mask)

        # Save segmentation mask
        seg_save_path = f"./Segmentation/{file.filename}"
        mask_pil.save(seg_save_path)

        """Encode mask image to Base64"""
        output_buffer = io.BytesIO()
        mask_pil.save(output_buffer, format="PNG")

        encoded_image = base64.b64encode(output_buffer.getvalue()).decode("utf-8")

        return {"image": f"data:image/png;base64,{encoded_image}"}

    except Exception as e:
        print(f"Error: {e}")
        return {"error": f"Processing error: {str(e)}"}
    
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)