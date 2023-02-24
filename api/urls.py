from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token
from . import views

urlpatterns = [
    path('', views.getRoutes, name='endpoint'),
    path('notes/', views.NoteList.as_view(), name='notes'),
    path('notes/<int:pk>/', views.GetNote.as_view(), name='view_note'),

    path('notes/<int:pk>/update/', views.GetNote.as_view(), name='update_note'),
    path('notes/<int:pk>/delete/', views.GetNote.as_view(), name='delete_note'),

    path('users/', views.UserList.as_view(), name='Users List'),
    path('login/', obtain_auth_token),
      
]