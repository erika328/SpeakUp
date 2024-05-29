let mediaRecorder;
let localStream;
let recordButton = document.getElementById('recordButton');
let stopButton = document.getElementById('stopButton');

recordButton.addEventListener('click', startRecording);
stopButton.addEventListener('click', stopRecording);

function startRecording() {
    navigator.mediaDevices.getUserMedia({audio: true })
    .then(function (stream) {
        localStream = stream;
        mediaRecorder = new MediaRecorder(stream);
        mediaRecorder.start();
        console.log("Status: " + mediaRecorder.state);
        recordButton.style.display = 'none'; // 録音開始ボタンを非表示に
        stopButton.style.display = 'block'; // 停止ボタンを表示する
    }).catch(function (err) {
        console.log(err);
    });
}

function stopRecording() {
    mediaRecorder.stop();

    recordButton.style.display = 'block'; // 録音開始ボタンを表示する
    stopButton.style.display = 'none'; // 停止ボタンを非表示に

    mediaRecorder.ondataavailable = function (event) {
        document.getElementById("audioPlayer").src = window.URL.createObjectURL(event.data);
    }
    localStream.getTracks().forEach(track => track.stop());
}
