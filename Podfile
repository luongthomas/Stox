source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings! # this will disable all the warnings for all pods

abstract_target 'Stocks' do
    pod 'SnapKit', '~> 4.0.0'
    pod 'Alamofire'
    pod 'AlamofireImage', '~> 3.3'
    
    target 'Stox'
    target 'Stox_Unit_Tests' do
        pod 'Mockingjay'
    end

    target 'StoxUITests' do
        pod 'Mockingjay'
    end

end