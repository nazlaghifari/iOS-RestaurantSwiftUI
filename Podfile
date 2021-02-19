# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://cdn.cocoapods.org/'
source 'https://github.com/nazlaghifari/Resto-CorePodSpecs.git'

use_frameworks!
inhibit_all_warnings!

workspace 'Restaurant'

target 'Restaurant' do
  # Pods for Restaurant
  pod 'RealmSwift'
  pod 'Alamofire'
  pod 'SDWebImageSwiftUI'
  pod 'RestoCore'

end

target 'Resto' do
  project 'Modules/Resto/Resto'
  # Pods for Meal
  pod 'RealmSwift'
  pod 'Alamofire'
  pod 'RestoCore'
 
end
