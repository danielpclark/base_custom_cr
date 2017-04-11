require "./spec_helper"

describe "BaseCustom" do
  it "base2" do
    base2 = BaseCustom.new("01")
    base2.base("00001").    should eq(1)
    base2.base("100110101").should eq(309)
    base2.base(340).        should eq("101010100")
    base2.base(0xF45).      should eq("111101000101")
    base2.base(0b111).      should eq("111")
  end
  
  it "baseABC" do
    baseABC = BaseCustom.new("ABC")
    baseABC.base("ABC").should eq(5)
    baseABC.base(123).  should eq("BBBCA")
  end
  
  it "base10" do
    base10 = BaseCustom.new("0123456789")
    base10.base(123).  should eq("123")
    base10.base("123").should eq(123)
  end
  
  it "errors" do
    base2 = BaseCustom.new("01")
    expect_raises Exception do base2.base("abc") end
    expect_raises Exception do BaseCustom.new(%w[:a :b :c]) end
  end
  
  it "delim" do
    base = BaseCustom.new(["a", "bb", "ccc", "dddd"], ' ')
    base.base( 20 ).should eq("bb bb a ")
    base.base( "bb bb a " ).should eq(20)
  end
  
  it "delim music" do
    baseMusic = BaseCustom.new(%w[A A# B C C# D D# E F F# G G#], ' ')
    baseMusic.base( (Math::PI * 100000000).to_i ).should eq("F F# B D# D A# D# F# ")
    baseMusic.base( "F F# B D# D A# D# F# " ).should eq((Math::PI * 100000000).to_i)
  end
  
  it "multi with delim" do
    baseMND = BaseCustom.new(%w(aa bb cc), ':')
    baseMND.base(12).should eq("bb:bb:aa:")
    baseMND.base("bb:bb:aa:").should eq(12)
  end
  
  it "multi in string with delim" do
    baseMND = BaseCustom.new("aa:bb:cc", ':')
    baseMND.base(12).should eq("bb:bb:aa:")
    baseMND.base("bb:bb:aa:").should eq(12)
  end

  it "special characters" do
    baseSC = BaseCustom.new("\n 0 1 \t", ' ')
    baseSC.base(12345).should eq("\t \n \n \n \t 1 0 ")
    baseSC = BaseCustom.new(["\n", "0", "1", "\t"])
    baseSC.base(12345).should eq("\t\n\n\n\t10")
    baseSC = BaseCustom.new("\n01\t")
    baseSC.base(12345).should eq("\t\n\n\n\t10")
  end

  it "has working getter methods" do
    baseSC2 = BaseCustom.new("\n 0 1 \t", ' ')
    baseSC2.length.should eq(4)
    baseSC2.all.should eq("\n 0 1 \t")
  end
end
