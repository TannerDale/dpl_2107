require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe Author do
  context 'initialize' do
    dpl = Library.new("Denver Public Library")

    it 'exists' do
      expect(dpl).to be_a(Library)
    end

    it 'has attributes' do
      expect(dpl.name).to eq("Denver Public Library")
      expect(dpl.books).to be_empty
      expect(dpl.authors).to be_empty
    end
  end

  context 'adding authors' do
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    it 'can add authors and their books' do
      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)

      expect(dpl.authors).to eq([charlotte_bronte, harper_lee])
      expect(dpl.books).to eq([jane_eyre, professor, villette, mockingbird])
    end
  end

  context 'publicaton time frames' do
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    it 'has publication time frames' do
      expected_1 = {:start=>"1847", :end=>"1857"}
      expected_2 = {:start=>"1960", :end=>"1960"}

      expect(dpl.publication_time_frame_for(charlotte_bronte)).to eq(expected_1)
      expect(dpl.publication_time_frame_for(harper_lee)).to eq(expected_2)
    end
  end
end
