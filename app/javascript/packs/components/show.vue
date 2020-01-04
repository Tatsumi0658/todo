<template>
  <div id="post">
    {{ $route.params.id }}<br>
    <!--{{ task.name }}*/-->
  </div>
</template>

<script>
export default{
  /*data(){
    return{
      tasks: tasks
    }
  },
  computed: {
    task(){
      return this.tasks.find(task => task.id = $route.params.id)
    }
  },
  data(){
    return{
      task_id: this.id
    }
  },
  computed:{
    getTask: function(task_id){
      return this.tasks.find(task => task.id === task_id)
    }
  }*/
  props: { id: Number }
}
</script>
