function getBadge(level) {
  switch (level) {
    case 'Beginner':
      return 'Easy';
    case 'Intermediate':
      return 'Medium';
    case 'Advanced':
      return 'Hard';
    default:
      return 'N/A';
  }
}

function CourseDetails(props) {
  let coursedet;

  if (props.courses.length === 0) {
    coursedet = <p>No courses available.</p>;
  } else {
    coursedet = (
      <ul>
        {props.courses.map((course) => (
          <div key={course.id}>
            <h3>{course.cname}</h3>
            <h4>{getBadge(course.level)}</h4>
          </div>
        ))}
      </ul>
    );
  }

  return (
    <div className="mystyle1">
      <h1>Course Details</h1>
      {coursedet}
    </div>
  );
}

export default CourseDetails;