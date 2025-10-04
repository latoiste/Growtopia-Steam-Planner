function downloadFile(json, filename) {
    console.log("FUCKK")
    const blob = new Blob([json], { type: "application/json"});
    const objectURL = URL.createObjectURL(blob);
    
    const a = document.createElement("a");
    a.href = objectURL;
    a.download = filename;

    a.click();
    a.remove();

    URL.revokeObjectURL(objectURL);
}

async function uploadFile() {
    const input = document.createElement("input");
    let data = null;
    input.type = "file";
    
    await new Promise((resolve, reject) => {
        input.addEventListener("change", (event) => {
            const file = event.target.files[0];
            if (!file) {
                reject("NO FILEEEEEEEEE")
            }
            else if (file.type !== "application/json") {
                reject("WEEE WOOOO WEEE WOOOO");
            }
            else {
                const content = new FileReader();
                content.readAsText(file);
                content.addEventListener("load", (event) => {
                    data = event.target.result;
                    console.log(typeof data);
                    resolve();
                });
            }
            input.remove();
        });
        input.click();
    }).then(() => {
        console.log("Suces");
        window.sendToGodot(data);
    }).catch((message) => {
        console.log(message);
        window.sendToGodot('{}');
    });
}