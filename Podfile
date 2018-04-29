source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings! # this will disable all the warnings for all pods

target 'Stox' do
    pod 'SnapKit', '~> 4.0.0'
	pod "Texture"
	pod 'Alamofire'
	pod 'Charts'

	target 'Stox_Unit_Tests' do
    	inherit! :search_paths
    end

    target 'StoxUITests' do
    	inherit! :search_paths
  	end
end

