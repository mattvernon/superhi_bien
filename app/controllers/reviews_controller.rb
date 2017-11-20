class ReviewsController < ApplicationController

    def index
      # this is our list page for our reviews
      @price = params[:price]
      @cuisine = params[:cuisine]
      @location = params[:location]

      # start with all reviews
      @reviews = Review.all

      # filtering by price
      if @price.present?
        @reviews = @reviews.where(price: @price)
      end

      # filter by cuisine
      if @cuisine.present?
        @reviews = @reviews.where(cuisine: @cuisine)
      end

      # search near the location
      if @location.present?
        @reviews = @reviews.near(@location) 
      end

    end

    def new
      # the form for adding a new review
      @review = Review.new
    end

    def create
      # take info from form and add to model
      @review = Review.new(form_params)

      # we want to check if the model can be saved
      # if it is, we'll go to home page
      # if it isn't, show the new form

      if @review.save
        redirect_to root_path
      else
        #show the view for new.html.erb
        render "new"

      end

    end

    def show
      # individual review page
      @review = Review.find(params[:id])
    end

    def destroy
      # find the invidiual review
      @review = Review.find(params[:id])
      #destory it
      @review.destroy
      #redirect to homepage
      redirect_to root_path
    end

    def edit
      #find the invidual review to edit
      @review = Review.find(params[:id])

    end

    def update
      # find the individual review
      @review = Review.find(params[:id])

        # update with new info from form
      if @review.update(form_params)
        #redirect to new review page
        redirect_to review_path(@review)
      else
        render "edit"
      end
    end

    def form_params
      params.require(:review).permit(:title, :restaurant, :body, :score, :ambiance, :price, :cuisine, :address)
    end

end
