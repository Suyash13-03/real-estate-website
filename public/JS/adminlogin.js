document.querySelector("#adminlogin").addEventListener("submit",async(event)=>{
    event.preventDefault();
    await getInfo();
});

async function getInfo(){
    let username=document.getElementById("username").value;
    let password=document.getElementById("password").value;
    try{
        let res=await axios.post("/home/adminlogin",{username,password});
        let data=res.data;
        if(data.success){
            alert(data.message);
            window.location.href="/home/admindashboard";
        }else{
            alert(data.message);
        };  
    }catch(err){
        console.log("Error-",err);
    }
};

