// reactInitializer.js
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './components/App';

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('react-root');
  if (container) {
    const root = createRoot(container);
    root.render(<App />);
  } else {
    console.warn("react-root element not found on this page.");
  }
});