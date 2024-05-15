import React from 'react';

const ShareButton = ({ score }) => {
  const shareScore = () => {
    const shareText = `英文発音採点で${score}を叩き出したよ!You should try! #SpeakUp \n`;
    const url = encodeURIComponent('https://speakup.fly.dev');
    const text = encodeURIComponent(shareText);
    const shareUrl = `https://twitter.com/intent/tweet?url=${url}&text=${text}`;

    window.open(shareUrl, '_blank');
  };

  return (
    <button onClick={shareScore}>
      <i className="fa-brands fa-x-twitter"></i>Share</button>
  );
};

export default ShareButton;