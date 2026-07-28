import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseCard } from '../../components/course-card/course-card';
import { Course } from '../../models/course.model';
import { CourseService } from '../../services/course.service';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCard, RouterLink],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css',
})
export class CourseList implements OnInit {

  isLoading = true;

  courses: Course[] = [];

  selectedCourseId:number|null=null;

  constructor(private courseService: CourseService) {}

  ngOnInit():void{

    this.courses = this.courseService.getCourses();

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