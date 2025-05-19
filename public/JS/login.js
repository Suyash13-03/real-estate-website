document.querySelector("#loginform").addEventListener("submit",async(event)=>{
    event.preventDefault();
    await getInfo();
});

async function getInfo(){
    let email=document.getElementById("email").value;
    let password=document.getElementById("password").value;
    try{
        let res=await axios.post("/home/login",{email,password});
        let data=res.data;
        if(data.success){
            alert(data.message);
            window.location.href="/apnaghar/home";
        }else{
            alert(data.message);
        };  
    }catch(err){
        console.log("Error-",err);
    }
};

