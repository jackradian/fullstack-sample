import styled from "@emotion/styled";

const MovieDiv = styled.div`
  margin-left: auto;
  margin-right: auto;
  margin-top: 20px;
  width: 600px;
  display: flex;
  gap: 10px;
`;

export default function Movie({ url, uploadedUsername }) {
  const getId = (urlString) => {
    const regExp =
      /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
    const match = urlString.match(regExp);

    return match && match[2].length === 11 ? match[2] : null;
  };

  const videoId = getId(url);
  const embedUrl = "https://www.youtube.com/embed/" + videoId;

  return (
    <MovieDiv>
      <div>
        <iframe
          width='320'
          height='180'
          src={embedUrl}
          title='YouTube video player'
          allow='accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share'
          allowFullScreen></iframe>
      </div>
      <div>Uploaded by {uploadedUsername}</div>
    </MovieDiv>
  );
}
