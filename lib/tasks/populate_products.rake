namespace :populate do
  desc 'Populates products table from external sites'
  task products: :environment do
    page = Nokogiri::HTML(open("http://www.amazon.com/Best-Sellers-Electronics-Unlocked-Cell-Phones/zgbs/electronics/2407749011/ref=acs_ux_rw_ts_e_2407749011_more?pf_rd_p=1961602542&pf_rd_s=merchandised-search-5&pf_rd_t=101&pf_rd_i=2407749011&pf_rd_m=ATVPDKIKX0DER&pf_rd_r=1ENHR5GQFRCADYNZMKA1#1"))
    page.css('.zg_itemImmersion').each do |product|

        image = product.css('.zg_itemImageImmersion img').attr('src').text
        title = product.css('.zg_title').text
        reviews = product.css('.zg_reviews').text
        price = product.css('.zg_price').text.slice(/\d+.\d+/)
        prd = Product.new(image: open(image), name: title, description: "#{title} reviews: #{reviews}", price: price)
        puts prd.save!
    end
  end
end
