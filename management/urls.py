from django.urls import path
from .views import home  # Ensure `home` is defined in views.py

urlpatterns = [
    path('', home, name='home'),  # Match the home URL
]
