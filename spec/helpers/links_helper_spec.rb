require 'spec_helper'

describe LinksHelper do
  describe "#full_url" do
    let(:link) { create(:link) }

    it "returns a full url" do
      expect(full_url(link)).to eq "shrt.nr/#{link.short_url}"
    end
  end
end
