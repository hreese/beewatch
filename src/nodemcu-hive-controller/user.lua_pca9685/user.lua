-- Initialize I2C bus with SDA on GPIO0, SCL on GPIO2
-- https://github.com/nodemcu/nodemcu-firmware/wiki/nodemcu_api_en#new_gpio_map
i2c.setup(0, 3, 4, i2c.SLOW)

-- Initialize PCA9685 PWM controller
-- Args:
--	i2c bus id (should be 0)
--	i2c address (see pca9685 datasheet)
--	mode - 16-bit value, low byte is MODE1, high is MODE2 (see datasheet)
require('pca9685')
pca9685.init(0, 0x40, 0)

for i=0,100,5 do
    set_chan_percent(0, i)
end
