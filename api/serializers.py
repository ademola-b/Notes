from asyncore import read
from statistics import mode
from django.contrib.auth.models import User

from rest_framework import serializers
from rest_framework.serializers import ModelSerializer, Serializer
from . models import Note


class UserDetails(Serializer):
    user = serializers.CharField(read_only = True)

class UserMiniSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['username']

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id','username', 'email']

        
class NoteSerializer(ModelSerializer):
    # owner = serializers.SerializerMethodField(read_only = True)
    user = UserMiniSerializer(read_only=True, required=False)
    class Meta:
        model = Note
        fields = [
            "id",
            "user",
            "body",
            "updated",
            "created",
            # "owner"
        ]
        # fields = '__all__'
    
    # def get_owner(self, obj):
    #     return {
    #         "username": obj.user.username
    #     }

class NoteCreateSerializer(ModelSerializer):
    class Meta:
        model = Note
        fields = '__all__'