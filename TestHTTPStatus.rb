require 'test/unit'
require_relative 'HTTPStatus'

class TestHTTPStatus < Test::Unit::TestCase
    def test_fetch
        page = Fetchers::HTTPStatus.new("http://www.google.com")
    	status = page.fetch
        assert_equal status, {:available=>true}

        page = Fetchers::HTTPStatus.new("http://www.cnn.com/index/")
    	status = page.fetch
        assert_equal status, {:available=>true}

        page = Fetchers::HTTPStatus.new("http://127.0.0.1")
    	status = page.fetch
        assert_equal status, nil

        page = Fetchers::HTTPStatus.new("http:thisistrulygarbage")
    	status = page.fetch
        assert_equal status, nil

        page = Fetchers::HTTPStatus.new("https://msp.f-secure.com/web-test/common/test.html")
    	status = page.fetch
        assert_equal status, {:available=>true}
    end
end
