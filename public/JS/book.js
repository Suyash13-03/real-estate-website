document.querySelector("#bookform").addEventListener("submit",async(event)=>{
    event.preventDefault();
    await addInfo();
});

async function addInfo(){
    let name=document.getElementById("name").value;
    let email=document.getElementById("email").value;
    let phone=document.getElementById("phone").value;
    let date=document.getElementById("date").value;  
    let propertyId=document.getElementById("propertyId").value;
    
try{
    let res=await axios.post(`/home/book/${propertyId}`,{name,email,phone,date});
    let data=res.data;
    if(data.success){
        alert("Appointment Booked Successfully!");
        window.location.href="/apnaghar/home";
    }
    else{
        alert("Something went wrong,try again");
    }
  }catch(err){
      console.log("Error-",err);
  }
};