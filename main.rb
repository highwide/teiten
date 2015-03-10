require 'bundler'
Bundler.require

img_names = Dir.glob('./image/*.JPG')

imgs = Magick::ImageList.new
img_names.each { |i| imgs << Magick::Image.read(i).first.rotate(90) }
 
imgs.map! { |i| i.resize(0.2)}
 
imgs.delay = 15
imgs.write ('./image/gif/animation.gif')
 
imgs.destroy!

p File.size('./image/gif/animation.gif')

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_SECRET']
end

gif = File.open('./image/gif/animation.gif')
@client.update_with_media('gifテストてすと', gif)
