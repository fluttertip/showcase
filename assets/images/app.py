import os

def rename_images(folder_path):
    images = sorted([f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))])
    for idx, filename in enumerate(images, start=1):
        ext = os.path.splitext(filename)[1]
        new_name = f"{idx}{ext}"
        os.rename(os.path.join(folder_path, filename), os.path.join(folder_path, new_name))

if __name__ == "__main__":
    folder_path = os.path.dirname(os.path.abspath(__file__))
    rename_images(folder_path)

