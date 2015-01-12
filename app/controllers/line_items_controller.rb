class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_job

  def accept 
    # 检查是否有人应聘
    if @job.line_items.present? 
      @job.line_items.each do |line_item|
          if line_item.mobile==current_user.mobile or line_item.email==current_user.email #找到推荐信
            line_item.talent_id = current_user.id 
            line_item.status = "等待反馈"
	    line_item.save
  	    break #找到推荐信就跳出循环，否则下面会重复推荐
  	  elsif line_item==@job.line_items.last#整个循环都没找到推荐信,要自己创建line_item,说明是自聘
    	    @line_item=@job.line_items.build(user_id:current_user.id,talent_id:current_user.id)#推荐人和候选人是一个人
            @line_item.status = "等待反馈"
            @line_item.save
  	    break #跳出循环，否则会无穷创建推荐
  	  end
      end
    else # 没人应聘，自聘
      @line_item=@job.line_items.build(user_id:current_user.id,talent_id:current_user.id,status:"等待反馈")
      @line_item.save
    end

    respond_to do |format|
      format.html { redirect_to @job, notice: '应聘成功' }
      format.js
      format.json { render partial: 'apply', status: :created, location: @job }      #刷新apply的列表,必须建立view/jobs/accept.js.erb文件
    end
  end

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @user = current_user

  # 这个职位推荐过人 
    if @job.line_items.present?
        # 查找有无重复推荐候选人
        @job.line_items.each do |f|
          if (f.mobile == params[:line_item][:mobile] && f.mobile.present?) or (f.email == params[:line_item][:email] && f.email.present?)
 	    redirect_to job_path(@job), notice: '不好意思，已经有人推荐了，继续努力哦' and return
     	  # 没有重复推荐
	  else
	    @line_item = @user.line_items.build(line_item_params)
	  end
        end
  
  # 这个职位没有推荐过人 
    else 
        @line_item = @user.line_items.build(line_item_params)
    end
   
  # line_item_params里面没有job_id，所以需要在这里单独给@line_item赋job_id
  @line_item.job_id = params[:job_id]
  
  if @line_item.city.present? and @line_item.city != @job.city
    redirect_to :back,notice: '城市不对，您想两地分居吗?' and return
  else
    @line_item.status = "等待应聘"
  end

  respond_to do |format|
      if @line_item.save
        format.html { redirect_to @job, notice: '推荐成功' }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_job
      @job = Job.find(params[:job_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # line_items/_form里只输入这几项
    def line_item_params
      params.require(:line_item).permit(:mobile, :email, :name, :city)
    end
end
