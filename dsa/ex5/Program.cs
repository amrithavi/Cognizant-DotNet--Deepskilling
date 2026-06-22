using System;

public class Task
{
  public int TaskId {get;set;}
  public string TaskName {get;set;}
  public string Status {get;set;}
  public Task(int taskId, string taskName, string status)
  {
    TaskId=taskId;
    TaskName=taskName;
    Status=status;
  }

  public override string ToString()
  {
   return $"ID:{TaskId},Name:{TaskName},Status:{Status}";
  }
}
public class TaskNode
{
  public Task Data;
  public TaskNode Next;

  public TaskNode(Task task)
  {
    Data=task;
    Next=null;
  }
}

public class TaskLinkedList
{
  private TaskNode head;
  public void AddTask(Task task)
  {
    TaskNode newNode=new TaskNode(task);
    if (head==null)
    {
      head=newNode;
      return;
    }
    TaskNode current=head;
    while (current.Next!=null)
    {
      current=current.Next;
    }
    current.Next=newNode;
  }
  public Task SearchTask(int taskId)
  {
    TaskNode current=head;
    while (current!=null)
    {
      if (current.Data.TaskId==taskId)
      {
        return current.Data;
      }
      current=current.Next;
    }
    return null;
  }
  public void TraverseTasks()
  {
    if (head==null)
    {
      Console.WriteLine("not available");
      return;
    }
    TaskNode current=head;
    while (current!=null)
    {
      Console.WriteLine(current.Data);
      current=current.Next;
    }
  }
  public bool DeleteTask(int taskId)
  {
    if (head==null)
    return false;
    if (head.Data.TaskId==taskId)
    {
      head=head.Next;
      return true;
    }
    TaskNode current=head;
    while (current.Next!=null &&
    current.Next.Data.TaskId!=taskId)
    {
      current=current.Next;
    }
    if (current.Next==null)
    return false;
    current.Next=current.Next.Next;
    return true;
  }
}
class Program
{
  static void Main()
  {
    TaskLinkedList taskList=new TaskLinkedList();
    taskList.AddTask(new Task(1,"design database","pending"));
    taskList.AddTask(new Task(2,"develop API","in progress"));
    taskList.AddTask(new Task(3, "testing", "pending"));
    Console.WriteLine("all tasks:");
    taskList.TraverseTasks();

    Console.WriteLine("searching for Task ID 2:");
    Task foundTask=taskList.SearchTask(2);
    if (foundTask!=null)
      Console.WriteLine(foundTask);
    else
      Console.WriteLine("Task not found.");
      
    Console.WriteLine("deleting task ID 2...");
    bool deleted=taskList.DeleteTask(2);
    Console.WriteLine(deleted
      ? "task deleted successfully."
      : "task not found.");
    Console.WriteLine("tasks after deletion:");
    taskList.TraverseTasks();
  }
}
