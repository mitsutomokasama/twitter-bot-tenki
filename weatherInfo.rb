#encoding: utf-8

require 'rubygems'
require 'open-uri'

#
# 天気予報を取得するクラス
#
class WeatherInfo
	#
	#東京の天気情報を取得
	#天気、最高気温、最低気温、降水率(06-12)、(12-18)、(18-24)を戻す
	def get_tokyo_info
		xml = parse_xml
		date =Time.new.strftime("%Y/%m/%d")
		info = {}
		return info unless /<area id=\"東京地方\">.*<info date=\"#{date}\">(.*?)<\/info>.*<\/area>/m =~ xml
		area = $1
		area =~ /<weather>(.*)<\/weather>/m; info['weather'] = $1
		area =~ /<range centigrade="max">(.*)<\/range>/; info['max'] = $1
		area =~ /<range centigrade="min">(.*)<\/range>/; info['min'] = $1
		area =~ /<period hour="06-12">(.*)<\/period>/; info['06-12'] = $1
		area =~ /<period hour="12-18">(.*)<\/period>/; info['12-18'] = $1
		area =~ /<period hour="18-24">(.*)<\/period>/; info['18-24'] = $1
		return info
	end

	def parse_xml
		xml = open("http://www.drk7.jp/weather/xml/13.xml") do |data|
			data.read
		end
		xml.force_encoding('UTF-8')
	end
end
