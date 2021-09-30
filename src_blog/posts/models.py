from django.conf import settings
from django.db import models
from django.contrib.auth import get_user_model
from tinymce.models import HTMLField


from django.utils import timezone

User = get_user_model()

class Author(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    profile_picture = models.ImageField()

    def __str__(self):
        return self.user.username
        

class Category(models.Model):
    title = models.CharField(max_length=20)

    def __str__(self):
        return self.title


class Post(models.Model):
    title = models.CharField(max_length=200)
    overview = models.TextField(blank=True, null=True)
    content = HTMLField()
    thumbnail = models.ImageField(blank=True, null=True)

    author = models.ForeignKey(Author, on_delete=models.CASCADE)
    categories = models.ManyToManyField(Category)
    featured = models.BooleanField(default=False)
    

    created_date = models.DateTimeField(default=timezone.now)
    published_date = models.DateTimeField(blank=True, null=True)

    # previous_post = models.ForeignKey(
    #     'self', related_name='previous', on_delete=models.SET_NULL, blank=True, null=True)
    # next_post = models.ForeignKey(
    #     'self', related_name='next', on_delete=models.SET_NULL, blank=True, null=True)

    def publish(self):
        self.published_date = timezone.now()
        self.save()

    def __str__(self):
        return self.title

