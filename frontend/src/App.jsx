import { useContext } from "react";
import { Routes, Route, useLocation, Navigate } from "react-router-dom";
import BaseLayout from "./layouts/BaseLayout";
import HomePage from "./pages/HomePage";
import ShareMoviePage from "./pages/ShareMoviePage";
import AuthProvider from "./contexts/AuthContext";
import { authContext } from "./contexts/AuthContext";

export default function App() {
  return (
    <AuthProvider>
      <Routes>
        <Route element={<BaseLayout />}>
          <Route path='/' element={<HomePage />} />
          <Route
            path='/share'
            element={
              <RequireAuth>
                <ShareMoviePage />
              </RequireAuth>
            }
          />
        </Route>
      </Routes>
    </AuthProvider>
  );
}

function RequireAuth({ children }) {
  const { auth } = useContext(authContext);
  let location = useLocation();

  if (!auth.accessToken) {
    // Redirect them to the /login page, but save the current location they were
    // trying to go to when they were redirected. This allows us to send them
    // along to that page after they login, which is a nicer user experience
    // than dropping them off on the home page.
    return <Navigate to='/' state={{ from: location }} replace />;
  }

  return children;
}
