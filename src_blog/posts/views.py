from django.shortcuts import render, get_object_or_404
from .models import Post

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
# Create your views here.

def index_page(request):
    featured = Post.objects.filter(featured=True)
    latest = Post.objects.order_by('-created_date')[0:3]
    context = {
        'featured_list': featured,
        'latest_list': latest
    }
 
    return render(request, 'posts/index.html', context)



def post_all(request):
    post_all = Post.objects.all()
    page = request.GET.get('page',1)
    paginator =Paginator(post_all,2)
    try:
        page_obj = paginator.page(page)
    except PageNotAnInteger:
        page_obj = paginator.page(1)
    except EmptyPage:
        page_obj = paginator.page(paginator.num_pages)

    return render(request, 'posts/blog.html', { 'page_obj': page_obj })


def post_detail(request,id):
    postDetail = get_object_or_404(Post, id=id)
    context = {
    'post': postDetail,
    }
    return render(request,'posts/post_detail.html',context)
