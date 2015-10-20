require 'rails_helper'

RSpec.describe "comments/show", :type => :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :content => "Content",
      :post => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(//)
  end
end
