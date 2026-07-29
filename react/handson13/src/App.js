import './App.css';
import BookDetails from './BookDetails';
import CourseDetails from './CourseDetails';
import BlogDetails from './BlogDetails';
import { books } from './books';
import { courses } from './courses';

function App() {
  return (
    <div className="row">
      <CourseDetails courses={courses} />
      <BookDetails books={books} />
      <BlogDetails showInstall={true} />
    </div>
  );
}

export default App;