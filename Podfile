platform :ios, '10.0'
use_frameworks!

def common_pods
  pod 'RxSwift', '3.4.1'
  pod 'RxCocoa', '3.4.1'
end

def testing_pods
  pod 'Nimble', '7.0.2'
  pod 'Quick', '1.2.0'
  pod 'RxTest', '3.2.0'
end

target 'rx-example' do
  common_pods
end

target 'rx-exampleTests' do
  inherit! :search_paths
  common_pods
  testing_pods
end
