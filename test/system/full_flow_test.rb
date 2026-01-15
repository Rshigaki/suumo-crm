require "application_system_test_case"

class FullFlowTest < ApplicationSystemTestCase
  setup do
    @company = Company.create!(name: "Test Company")
    @user = User.create!(email: "test_staff@example.com", password: "password", name: "Sales Staff", role: :staff, company: @company)
    @media_source = MediaSource.create!(name: "Website", company: @company)
    @customer = Customer.create!(name: "Test Customer", phone: "090-1234-5678", email: "customer@example.com", user: @user, company: @company, media_source: @media_source)
  end

  test "full sales cycle flow" do
    # 1. Login
    visit new_user_session_path
    fill_in "メールアドレス", with: @user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    assert_text "ダッシュボード"

    # 2. Interact with Dashboard (Start Recording)
    visit root_path
    click_button "録音スタート"

    # Should redirect to edit interaction (Recording State)
    assert_text "録音中"
    click_button "録音終了"

    # Should show review form
    assert_text "文字起こし" 
    
    # 3. Complete Interaction
    select @customer.name, from: "interaction[customer_id]"
    fill_in "interaction[memo]", with: "Very interested in the new plan."
    click_on "保存する"

    # Should redirect and show success and points
    assert_text "Interaction completed"
    assert_text "10 points"

    # 4. Check Interactions List
    click_on "接客履歴"
    assert_text @customer.name
    assert_text "完了"

    # 5. Create a Project
    click_on "案件管理"
    click_on "新規案件登録", match: :first
    
    fill_in "案件名", with: "New House Project"
    select @customer.name, from: "project[customer_id]"
    select "商談中", from: "project[status]"
    fill_in "見積金額", with: "35000000"
    click_on "保存"

    assert_text "案件を登録しました"
    assert_text "商談中"

    # 6. Check Reports
    click_on "分析レポート"
    assert_text "広告媒体"
  end
end
