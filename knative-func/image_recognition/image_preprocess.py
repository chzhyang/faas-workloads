import tensorflow as tf

def central_crop(image, crop_height, crop_width):
  """Performs central crops of the given image list"""
  shape = tf.shape(input=image)
  height, width = shape[0], shape[1]

  amount_to_be_cropped_h = (height - crop_height)
  crop_top = amount_to_be_cropped_h // 2
  amount_to_be_cropped_w = (width - crop_width)
  crop_left = amount_to_be_cropped_w // 2
  return tf.slice(image, [crop_top, crop_left, 0], [crop_height, crop_width, -1])

def mean_image_subtraction(image, means, num_channels):
  """Subtracts the given means from each image channel"""
  if image.get_shape().ndims != 3:
    raise ValueError('Input must be of size [height, width, C>0]')

  if len(means) != num_channels:
    raise ValueError('len(means) must match the number of channels')

  means = tf.broadcast_to(means, tf.shape(image))

  return image - means

def _smallest_size_at_least(height, width, resize_min):
  """Computes new shape with the smallest side equal to smallest_side"""
  resize_min = tf.cast(resize_min, tf.float32)

  # Convert to floats to make subsequent calculations go smoothly.
  height, width = tf.cast(height, tf.float32), tf.cast(width, tf.float32)

  smaller_dim = tf.minimum(height, width)
  scale_ratio = resize_min / smaller_dim

  # Convert back to ints to make heights and widths that TF ops will accept.
  new_height = tf.cast(height * scale_ratio, tf.int32)
  new_width = tf.cast(width * scale_ratio, tf.int32)

  return new_height, new_width

def image_resize(image, resize_min):
  """Resize images preserving the original aspect ratio"""
  shape = tf.shape(input=image)
  height, width = shape[0], shape[1]
  new_height, new_width = _smallest_size_at_least(height, width, resize_min)
  # Simple wrapper around tf.resize_images
  resized_image = tf.compat.v1.image.resize(image, [new_height, new_width], method=tf.image.ResizeMethod.BILINEAR, align_corners=False)

  return resized_image

