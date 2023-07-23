import os
import sys
sys.path.append(os.getcwd()+"/guided-diffusion-keras/guided_diffusion")
from tensorflow import keras

print("dnfkvjdnfjvk")
from diffuser import Diffuser
print("dnfkvjdnfjvkdvdfv")

model_path = os.getcwd()+"/model_test_aesthetic.h5"
import tensorflow as tf

print(model_path,  tf. __version__)

autoencoder = keras.models.load_model(model_path, compile=False, safe_mode=False)


# prompt = "mountain landscape with cloudy sky"

# class_guidance = 5

# diffusion_steps = 200

# seed =  1

# big_diffuser = Diffuser(autoencoder,
#                         class_guidance=class_guidance,
#                         diffusion_steps=diffusion_steps, )

# print(big_diffuser.noise_levels)

# num_imgs = 25
# np.random.seed(seed) #- 100/120 baseline
# rand_image = np.random.normal(0, 1, (num_imgs, image_size, image_size, num_channels))

# prompt=[prompt]*num_imgs

# labels = get_text_encodings(prompt, model)

# imgs = big_diffuser.reverse_diffusion(rand_image, labels, show_img=False
#                                       )
# plot_images(imgs, nrows=int(np.sqrt(num_imgs)), save_name=prompt[0], size=12)