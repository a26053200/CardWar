Shader "Game/UVFrameAnimation" 
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Sequence Image", 2D) = "white" {}
        _Speed("Speed", Range(1,100)) = 50
        _HorizontalAmount ("Horizontal Amount",float) = 4
        _VerticalAmount ("Vertical Amount",float) = 4
        _Cutout("CutOut", Range(0,1)) = 0.5
        _Alpha("Alpha", Range(0,1)) = 1
        _Rect1("Rect1", Vector) = (1,1,1,1)
        _Rect2("Rect2", Vector) = (1,1,1,1)
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" "RenderType" = "Transparent"}
        //ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            //Tags{"LightMode" = "ForwardBase"}
            
            CGPROGRAM
            //#pragma multi_compile_fwdbase
            #include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Speed;
            float _HorizontalAmount;
            float _VerticalAmount;
            float _Alpha;
            float _Cutout;

            float4 _Rect1;
            float4 _Rect2;
            struct a2v
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

               

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float time = floor(_Time.y  / 64 * _Speed);
                int idx = floor(fmod(time, 64));
                float4 rect = _Rect1;
                if(idx < 1)
                    rect = _Rect1;
                else
                    rect = _Rect2;
                float2 uv = i.uv * rect.zw + float2(rect.y, -rect.x);

                //float time = floor(_Time.y * _Speed);
                //float row = floor(time / _HorizontalAmount);
                //float colum = time - row * _HorizontalAmount;
                //half2 uv = i.uv + half2(colum,-row);
                //uv.x /=  _HorizontalAmount;
                //uv.y /=  _VerticalAmount;

                fixed4 c = tex2D(_MainTex, uv);
                //clip(c.a - _Cutout);
                //c.rgb *= _Color;
                return c;
            }
            ENDCG

        }

    }
    Fallback "Mobile/Diffuse"
}