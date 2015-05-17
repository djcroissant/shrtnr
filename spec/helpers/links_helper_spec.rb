require 'spec_helper'

describe LinksHelper do
  describe "#full_url" do
    let(:link) { create(:link) }

    it "returns a full url" do
      actual = "uwshrtnr.herokuapp.com/#{link.short_url}"
      expect(full_url(link)).to eq actual
    end
  end
end
