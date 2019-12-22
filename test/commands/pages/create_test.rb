# frozen_string_literal: true

require_relative '../../test_helper'

class Commands::Pages::CreateTest < TestCase
  def test_creates_a_page
    params = {
      url: 'http://google.com',
      status: 200,
      title: 'Google'
    }

    assert Commands::Pages::Create.call(params)

    page = Page.find_by(url: params[:url])

    assert page.status == params[:status]
    assert page.title == params[:title]
  end

  def test_saves_error_to_title_field_with_0_status
    params = {
      error: 'something wrong',
      url: 'http://google.com'
    }

    assert Commands::Pages::Create.call(params)

    page = Page.find_by(url: params[:url])

    assert page.status == 0
    assert page.title == params[:error]
  end
end
