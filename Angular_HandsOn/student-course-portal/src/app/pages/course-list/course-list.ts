import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseCard } from '../../components/course-card/course-card';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCard],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css',
})
export class CourseList implements OnInit {

  isLoading = true;

  courses:{
    id:number;
    name:string;
    code:string;
    credits:number;
    gradeStatus:'passed'|'failed'|'pending';
  }[]=[
    {
      id:1,
      name:'Angular',
      code:'ANG101',
      credits:4,
      gradeStatus:'passed'
    },
    {
      id:2,
      name:'C#',
      code:'CS102',
      credits:3,
      gradeStatus:'pending'
    },
    {
      id:3,
      name:'SQL',
      code:'SQL103',
      credits:2,
      gradeStatus:'failed'
    },
    {
      id:4,
      name:'ASP.NET Core',
      code:'ASP104',
      credits:4,
      gradeStatus:'passed'
    },
    {
      id:5,
      name:'JavaScript',
      code:'JS105',
      credits:3,
      gradeStatus:'pending'
    }
  ];

  selectedCourseId:number|null=null;

  ngOnInit():void{

    setTimeout(()=>{

      this.isLoading=false;

    },1500);

  }

  onEnroll(courseId:number){

    console.log("Enrolling in course: "+courseId);

    this.selectedCourseId=courseId;

  }

  trackByCourseId(index:number,course:any){

    return course.id;

  }

}