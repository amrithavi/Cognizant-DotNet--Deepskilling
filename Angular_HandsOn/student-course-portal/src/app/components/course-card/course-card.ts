import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';

@Component({
  selector: 'app-course-card',
  standalone: true,
  imports: [],
  templateUrl: './course-card.html',
  styleUrl: './course-card.css',
})
export class CourseCard implements OnChanges {

  @Input() course!: {
    id: number;
    name: string;
    code: string;
    credits: number;
  };

  @Output() enrollRequested = new EventEmitter<number>();

  ngOnChanges(changes: SimpleChanges): void {
    console.log('Course changed:', changes['course']);
  }

  enroll() {
    this.enrollRequested.emit(this.course.id);
  }
}