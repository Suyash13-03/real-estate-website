const express=require("express");
const app=express();
const mysql=require("mysql2");
const path=require("path");
const nodemailer=require("nodemailer");

app.set("view engine","ejs");
app.set("views",path.join(__dirname,"/views"));
app.use(express.urlencoded({extended:true}));
app.use(express.static(path.join(__dirname,"/public")));
app.use(express.json());

const connection=mysql.createConnection({
    host:'localhost',
    user:'root',
    database:'real_estate',
    password:'suyash1324'
});

const transporter=nodemailer.createTransport({
    host:"smtp.gmail.com",
    port:465,
    secure:true,
    auth:{
        user:"apnaghar2477@gmail.com",
        pass:"krnyjojzxmwljhrz"
    },
    tls:{
        rejectUnauthorized:false
    }
});

app.get("/apnaghar/home",(req,res)=>{
    res.render("homepage.ejs");
});

app.get("/home/signup",(req,res)=>{
    res.render("signup.ejs");
});

app.post("/home/signup",(req,res)=>{
    let{username,email,password,phonenumber}=req.body;
    let q=`INSERT INTO user(name,email,password,phone)VALUES('${username}','${email}','${password}','${phonenumber}')`;
      connection.query(q,(err,result)=>{
            if(err){
                if(err.code==="ER_DUP_ENTRY"){
                    return res.send("Email already exists,try again.");
                }
            }
           return res.redirect("/home/login");
        });
});

app.get("/home/login",(req,res)=>{
    res.render("login.ejs");
});

app.post("/home/login",(req,res)=>{
     let{email,password}=req.body;
     let q=`SELECT * FROM user WHERE email=?`;
     try{
        connection.query(q,[email],(err,result)=>{
           if(err) throw err;
           let user=result[0];
           if(password==user.password){
              return res.json({success:true,message:"Login Successful !"});
           }else{
             return res.json({success:false,message:"Incorrect credentials,try again"});
           }
        });
     }catch(err){
        console.log(err);
        res.send("some error in db");
     }
});

app.get("/home/buy",(req,res)=>{
    let q=`SELECT p.id,p.title,p.price,p.location,GROUP_CONCAT(pi.image) AS image
           FROM property p
           JOIN property_image pi ON p.id=pi.property_id
           WHERE p.type='buy' AND pi.image LIKE '%liv%'
           GROUP BY p.id,p.title,p.price,p.location`;
    connection.query(q,(err,property)=>{
        if(err){
            console.log("Error-",err);
            return res.send("Error in database");
        }
        res.render("buy.ejs",{property});
    }); 
});

app.get("/home/buy/:id",(req,res)=>{
    let{id}=req.params;
    let q=`SELECT p.*,pi.image
          FROM property p
          JOIN property_image pi ON p.id=pi.property_id
          WHERE p.id=?`;
    connection.query(q,[id],(err,result)=>{
        if(err){
            console.log("Error-",err);
            return res.send("Something went wrong.");
        }
        res.render("buydetails.ejs",{property:result});
    });
});

app.get("/home/rent",(req,res)=>{
    let q=`SELECT p.id,p.title,p.price,p.location,GROUP_CONCAT(pi.image) AS image
           FROM property p
           JOIN property_image pi ON p.id=pi.property_id
           WHERE p.type='rent' AND pi.image LIKE '%liv%' 
           GROUP BY p.id,p.title,p.price,p.location`;
    connection.query(q,(err,property)=>{
        if(err){
            console.log("Error-",err);
            return res.send("Error in database");
        }
        res.render("rent.ejs",{property});
    }); 
});

app.get("/home/rent/:id",(req,res)=>{
    let{id}=req.params;
    let q=`SELECT p.*,pi.image
          FROM property p
          JOIN property_image pi ON p.id=pi.property_id
          WHERE p.id=?`;
    connection.query(q,[id],(err,result)=>{
        if(err){
            console.log("Error-",err);
            return res.send("Something went wrong.");
        }
        res.render("rentdetails.ejs",{property:result});
    });
});

app.get("/home/about",(req,res)=>{
    res.render("about.ejs");
});

app.get("/home/contact",(req,res)=>{
    res.render("contact.ejs");
});

app.get("/home/book/:id",(req,res)=>{
    let{id}=req.params;
    let q=`SELECT * FROM property WHERE id=?`;
    connection.query(q,[id],(err,result)=>{
        if(err){
            console.log("Error-",err);
            return res.send("Something went wrong.");
        }
        res.render("book.ejs",{property:result[0]});
    });
}); 

app.post("/home/book/:id",(req,res)=>{
    let{id}=req.params;
    let{name,email,phone,date}=req.body;
    let q=`INSERT INTO appointment(property_id,name,email,phone,appointment_date)VALUES(?,?,?,?,?)`;
    connection.query(q,[id,name,email,phone,date],(err,result)=>{
        if(err){
            console.log("Error-",err);
            return res.json({success:false});
        }

        const mailOptions={
            from:"apnaghar2477@gmail.com",
            to:email,
            subject:"Appointment Confirmation",
            text:`Dear ${name},\n\nYour appointment for the property ID:${id} has been successfully booked on ${date}.\n\nWe will contact you soon,\nThank you!`
        };

        const adminMailOptions={
            from:"apnaghar2477@gmail.com",
            to:"apnaghar2477@gmail.com",
            subject:"New Appointment Booked",
            text:`A new appointment has been booked.\n\nName:${name}\nEmail:${email}\nPhone No.:${phone}\nDate:${date}\nPropertyId:${id}`
        };

        transporter.sendMail(mailOptions,(error,info)=>{
            if(error){
                console.log("Email error:",error);
                return res.json({success:false});
            }
        transporter.sendMail(adminMailOptions,(adminError,adminInfo)=>{
            if(adminError){
                console.log("Admin email error:",adminError);
                return res.json({success:false});
            }
            return res.json({success:true});
        });
        });

    });
});

app.get("/home/search",(req,res)=>{
    let{query}=req.query;
    let q=`SELECT p.id,p.title,p.price,p.location,p.type,GROUP_CONCAT(pi.image) AS image
           FROM property p
           JOIN property_image pi ON p.id=pi.property_id
           WHERE pi.image LIKE '%liv%'
           AND(p.title LIKE ? OR
           p.location LIKE ? OR
           p.price LIKE ? OR
           p.type LIKE ?)
           GROUP BY p.id,p.title,p.price,p.location,p.type;`
    let values=[`%${query}%`,`%${query}%`,`%${query}%`,`%${query}%`];
    connection.query(q,values,(err,result)=>{
        if(err) throw err;
        res.render("searchresults.ejs",{property:result,searchQuery:query});
    });
});

app.get("/home/adminlogin",(req,res)=>{
    res.render("adminlogin.ejs");
});

app.post("/home/adminlogin",(req,res)=>{
     let{username,password}=req.body;
     let q=`SELECT * FROM admin WHERE username=?`;
     connection.query(q,[username],(err,result)=>{
        if(err) throw err;
        let user=result[0];
        if(password==user.password){
            return res.json({success:true,message:"Login Successful !"});
        }else{
            return res.json({success:false,message:"Incorrect credentials,try again"});
        }
     });
});

app.get("/home/admindashboard",(req,res)=>{
    res.render("admindashboard.ejs");
});

app.get("/home/addproperty",(req,res)=>{
    res.render("addproperty.ejs");
});

app.post("/home/addproperty",(req,res)=>{
    let{title,location,price,description,amenities,type,deposit}=req.body;
    let q=`INSERT INTO property(title,location,price,description,amenities,type,deposit)
           VALUES(?,?,?,?,?,?,?)`
    connection.query(q,[title,location,price,description,amenities,type,deposit],(err,result)=>{
        if(err){
            res.send("Something went wrong");
        }
        else{
            res.render("addpropimage.ejs");
        }
    });
});

app.post('/home/addpropimage', (req, res) => {
    const { property_id, living_room, bedroom_1, bedroom_2, bedroom_3, kitchen, bathroom } = req.body;
    let sql = `INSERT INTO property_image (property_id, image) VALUES (?, ?), (?, ?), (?, ?), (?, ?)`;
    let values = [
        property_id, living_room,
        property_id, bedroom_1,
        property_id, kitchen,
        property_id, bathroom
    ];

    if (bedroom_2) {
        sql += ", (?, ?)";
        values.push(property_id, bedroom_2);
    }
    if (bedroom_3) {
        sql += ", (?, ?)";
        values.push(property_id, bedroom_3);
    }
    
    connection.query(sql,values,(err,result)=>{
        if(err){
            res.send("something went wrong");
        }else{
            res.render("admindashboard.ejs");
        }
    });
});

app.get("/home/updateproperty",(req,res)=>{
    res.render("updateproperty.ejs");
});

app.post("/home/updateproperty", (req, res) => {
    const {property_id, title, location, price, status, description, amenities, type, deposit } = req.body;

    if (!property_id) {
        return res.status(400).send("Property ID is required");
    }

    let updates = [];
    let values = [];

    if (title) {
        updates.push("title = ?");
        values.push(title);
    }
    if (location) {
        updates.push("location = ?");
        values.push(location);
    }
    if (price) {
        updates.push("price = ?");
        values.push(price);
    }
    if (status) {
        updates.push("status = ?");
        values.push(status);
    }
    if (description) {
        updates.push("description = ?");
        values.push(description);
    }
    if (amenities) {
        updates.push("amenities = ?");
        values.push(amenities);
    }
    if (type) {
        updates.push("type = ?");
        values.push(type);
    }
    if (deposit) {
        updates.push("deposit = ?");
        values.push(deposit);
    }

    if (updates.length === 0) {
        return res.status(400).send("No fields to update");
    }

    let sql = `UPDATE property SET ${updates.join(", ")} WHERE id = ?`;
    values.push(property_id);

    connection.query(sql, values, (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).send("Something went wrong");
        }
        res.render("admindashboard.ejs");
    });
});

app.get("/home/deleteproperty",(req,res)=>{
    res.render("deleteproperty.ejs");
});

app.post("/home/deleteproperty",(req,res)=>{
    let{property_id}=req.body;
    let q=`DELETE FROM property WHERE id=?`;
    connection.query(q,[property_id],(err,result)=>{
        if(err){
            res.send("Something went wrong,Please try again.")
        }else{
            res.render("admindashboard.ejs");
        }
    });
});

app.listen("8080",(req,res)=>{
    console.log("app is listening");
});