class LineItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  STATUS = ["等待应聘","拒绝应聘","等待反馈","一面","最后面试","HR拒绝","offer","保证期中","推荐成功"]
end
