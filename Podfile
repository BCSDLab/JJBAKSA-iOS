# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'jjbaksa' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for jjbaksa
  pod 'NMapsMap'

  pod "RichEditorView"
  use_frameworks!
  
  pod 'KakaoSDKAuth'  # 사용자 인증
  pod 'KakaoSDKUser'  # 카카오 로그인, 사용자 관리
  pod 'naveridlogin-sdk-ios' # 네이버 로그인
  pod 'GoogleSignIn' # 구글 로그인
  pod 'GoogleSignInSwiftSupport' # 'Google 계정으로 로그인' 버튼의 포드 확장 프로그램

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
               end
          end
   end
end
