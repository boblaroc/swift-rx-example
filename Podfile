platform :ios, '10.0'
use_frameworks!

def common_pods
  pod 'RxSwift', '3.4.0'
  pod 'RxCocoa', '3.4.0'
end

def testing_pods
  pod 'Quick', '1.1.0'
  pod 'Nimble', '6.0.1'
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
