import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/web_view/web_view.dart';
Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(10.0),
  
    child: SizedBox(
  
      height: 120,
  
      child: Row(
  
        crossAxisAlignment: CrossAxisAlignment.start,
  
        children: [
  
          Column(
  
            children:
  
            [
  
              Expanded(
  
                child: Container(
  
                  width: 120,
  
                  height: 120,
  
                  decoration: BoxDecoration(
  
                    borderRadius: BorderRadius.circular(10,),
  
                    image: DecorationImage(
  
                      image: NetworkImage('${article['urlToImage']}'),
  
                      fit: BoxFit.cover,),
  
                  ),
  
                ),
  
              ),
  
              const SizedBox(height: 5,),
  
              Text(
  
                '${article['publishedAt']}',style: const TextStyle(color: Colors.grey),
  
              ),
  
            ],
  
          ),
  
          const SizedBox(width: 10,),
  
          Expanded(
  
            child: Text(
  
              '${article['title']}',
  
              style:Theme.of(context).textTheme.bodyText1,
  
              maxLines: 3,
  
              overflow: TextOverflow.ellipsis,
  
            ),
  
          ),
  
        ],
  
      ),
  
    ),
  
  ),
);

Widget articleBuilder(list,context, {isSearch = false})=>ConditionalBuilder(
  condition: list.length> 0,
  builder: (context)=> ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index],context) ,
    separatorBuilder: (context,index)=> Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ),
    itemCount: 10,),
  fallback:(context)=>isSearch?Container(): const Center(child: CircularProgressIndicator()) ,
);


Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onFieldSubmit,
  Function onChange,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  bool isPass = false,
  IconData sufix  ,
  Function suffixPress,
  Function onTap,



})=>
    TextFormField(
      validator: validate,
      obscureText: isPass,
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: sufix != null?IconButton(onPressed: suffixPress,
          icon: Icon(
            sufix,
          ),
        ): null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),

      ),
    );

void navigateTo(context,widget) =>Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context)=>widget,
),
);