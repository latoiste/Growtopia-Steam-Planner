function downloadFile(json, filename) {
    console.log("FUCKK")
    let jsonString = JSON.stringify(json);
    const blob = new Blob([jsonString], { type: "application/json"});
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
    let data;
    input.type = "file";
    
    await new Promise(resolve => {
        input.addEventListener("change", (event) => {
            const file = event.target.files[0];
            if (!file) {
                console.log("NO FILEEEEEEEEE");
            }
            else if (file.type !== "application/json") {
                console.log("WEEE WOOOO WEEE WOOOO");
            }
            else {
                const content = new FileReader();
                content.readAsText(file);
                content.addEventListener("load", (event) => {
                    const result = event.target.result;
                    data = JSON.parse(result);
                    resolve();
                });
            }
            input.remove();
        });
        input.click();
    });
    window.sendToGodot(data);
}