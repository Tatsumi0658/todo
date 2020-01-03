<template>
  <div>
    <div class="row">
      <div class="col s10 m11">
        <!--<input class="form-control" placeholder="Add your task">-->
        <input v-model="newTask" class="form-control" placeholder="Add your task">
      </div>
      <div class="col s2 m1">
        <!--<div class="btn-floating waves-effect waves-light red">-->
        <div v-on:click="createTask" class="btn-floating waves-effect waves-light red">
          <i class="material-icons">add</i>
        </div>
      </div>
      <div>
        <ul class="collection">
          <!--<li id="row_task_1" class="collection-item">
            <input type="checkbox" id="task_1">
            <label for="task_1">Sample Task</label>
          </li>
          <li id="row_task_2" class="collection-item">
            <input type="checkbox" id="task_2">
            <label for="task_2">Smaple Task</label>
          </li>
          <li id="row_task_3" class="collection-item">
            <input type="checkbox" id="task_3">
            <label for="task_3">Sample Task</label>
          </li>-->
          <li v-for="task in tasks" v-if="!task.is_done" v-bind:id="'row_task_'+task.id" class="collection-item">
            <!--<input type="checkbox" v-bind:id="'task_'+task.id">-->
            <input type="checkbox" v-on:change="doneTask(task.id)" v-bind:id="'task_'+task.id">
            <label v-bind:for="'task_'+task.id">{{ task.name }}</label>
            <router-link :to="'/show/' + task.id">詳細</router-link>
          </li>
        </ul>
      </div>
      <div class="btn" v-on:click="displayFinishedTasks">
        Display finished tasks
      </div>
      <div id="finished-tasks" class="display_none">
        <ul class="collection">
          <!--<li id="row_task_4" class="collection-item">
            <input type="checkbox" id="task_4" checked="checked">
            <label for="task_4">Done Task</label>
          </li>
          <li id="row_task_5" class="collection-item">
            <input type="checkbox" id="task_5" checked="checked">
            <label for="task_5">Done Task</label>
          </li>-->
          <li v-for="task in tasks" v-if="task.is_done" v-bind:id="'row_task_'+task.id" class="collection-item">
            <input type="checkbox" v-bind:id="'task_'+task.id" checked="checked">
            <label v-bind:for="'task_'+task.id" class="line-through">{{ task.name }}</label>
            <router-link :to="'/show/'+task.id">詳細</router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'

  /*CSRFtokenの付与*/
  axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  };

  export default {
    data: function(){
      return {
        tasks: [],
        newTask: ''
      }
    },
    mounted: function(){
      this.fetchTasks();
    },
    methods: {
      fetchTasks: function(){
        axios.get('./api/tasks').then((response)=>{
          for(var i = 0; i < response.data.tasks.length; i++){
            this.tasks.push(response.data.tasks[i]);
          }
        },(error)=>{
          console.log(error);
        });
      },
      displayFinishedTasks: function(){
        document.querySelector('#finished-tasks').classList.toggle('display_none');
      },
      createTask: function(){
        if(!this.newTask) return;

        axios.post('./api/tasks',{ task:{ name:this.newTask} }).then((response)=>{
          this.tasks.unshift(response.data.task);
          this.newTask = '';
        }, (error)=>{
          console.log(error);
        });
      },
      doneTask: function(task_id){
        axios.put('/api/tasks/'+task_id, { task: {is_done: true} }).then((response)=>{
          this.moveFinishedTask(task_id);
        },(error)=>{
          console.log(error);
        });
      },
      moveFinishedTask: function(task_id){
        var el = document.querySelector('#row_task_'+task_id);
        var el_clone = el.cloneNode(true);
        el.classList.add('display_none');
        el_clone.getElementsByTagName('input')[0].checked='checked';
        el_clone.getElementsByTagName('label')[0].classList.add('line-through');
        el_clone.getElementsByTagName('label')[0].classList.remove('word-color-black');
        var li = document.querySelector('#finished-tasks > ul > li:first-child');
        document.querySelector('#finished-tasks > ul').insertBefore(el_clone, li);
      }
    }
  }
</script>

<style scoped>
  [v-cloak]{
    display: none;
  }
  .display_none{
    display: none;
  }
  .line-through{
    text-decoration: line-through;
  }
</style>
