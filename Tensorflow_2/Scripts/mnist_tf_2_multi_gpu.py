#!/bin/python

from __future__ import absolute_import, division, print_function, unicode_literals
import tensorflow as tf
import time

NUM_GPUS = 4
BATCH_SIZE = 256

mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

start_time = time.time()
model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10, activation='softmax')
])

model = tf.keras.utils.multi_gpu_model(model, gpus=NUM_GPUS, cpu_merge=False)

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

model.fit(x_train, y_train, epochs=5, batch_size=BATCH_SIZE)
print("Train time:", time.time() - start_time)

model.evaluate(x_test,  y_test, verbose=2)
