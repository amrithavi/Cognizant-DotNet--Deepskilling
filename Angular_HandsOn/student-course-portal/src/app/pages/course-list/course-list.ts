import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseCard } from '../../components/course-card/course-card';
import { Course } from '../../models/course.model';
import { CourseService } from '../../services/course.service';
import { RouterLink } from '@angular/router';
import { Store } from '@ngrx/store';
import * as CourseActions from '../../store/course/course.actions';
import * as CourseSelectors from '../../store/course/course.selectors';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCard, RouterLink],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css',
})
export class CourseList implements OnInit {

  isLoading = true;
  errorMessage = '';

  courses: Course[] = [];

  selectedCourseId:number|null=null;

  constructor(
    private store: Store,
    private courseService: CourseService
  ) {}

ngOnInit(): void {

  this.store.dispatch(
    CourseActions.loadCourses()
  );

  this.store
    .select(CourseSelectors.selectAllCourses)
    .subscribe(courses => {

      this.courses = courses;

    });

  this.store
    .select(CourseSelectors.selectLoading)
    .subscribe(loading => {

      this.isLoading = loading;

    });

  this.store
    .select(CourseSelectors.selectError)
    .subscribe(error => {

      this.errorMessage = error ?? '';

    });

}

  onEnroll(courseId:number){

    console.log("Enrolling in course: "+courseId);

    this.selectedCourseId=courseId;

  }

  trackByCourseId(index:number,course:any){

    return course.id;

  }

}