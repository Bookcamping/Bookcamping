
describe User::SetupUser do
  it "should build user from omniauth" do
    omni = {'info' => {}, 'provider' => 'p', 'uid' => 'uid'}
    omni['info']['name'] = 'name'
    omni['info']['email'] = 'email@example.com'
    user = User::SetupUser.build_from_omniauth(omni)
    user.should_be_not nil
  end
end

